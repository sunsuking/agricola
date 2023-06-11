from django.apps import AppConfig

from core.redis import connection


class CardsConfig(AppConfig):
    default_auto_field = "django.db.models.BigAutoField"
    name = "cards"

    def ready(self):
        super().ready()
        from cards.models import Card, CardEffect
        redis = connection()
        cards = Card.objects.all().values('card_number', 'command', 'name', 'score', 'cost', 'condition')
        effects = CardEffect.objects.all().values('card_number', 'condition', 'effect', 'command')
        for effect in effects:
            redis.hset(f'cards:{effect["card_number"]}', effect["effect"], effect["command"])
            if effect['condition'] is not None:
                redis.hset(f'cards:effects:{effect["effect"]}', effect["card_number"], effect["condition"])
        redis.hset(
            'commands',
            mapping={card['card_number']: card['command'] for card in cards if card['command'] is not None}
        )
        redis.hset(
            'costs',
            mapping={card['card_number']: card['cost'] for card in cards if card['cost'] is not None}
        )
        redis.hset(
            'condition',
            mapping={card['card_number']: card['condition'] for card in cards if card['condition'] is not None}
        )

        redis.hset('cards', mapping={card['card_number']: str({
            'card_number': card['card_number'],
            'name': card['name'],
            'score': card['score']
        }) for card in cards})
