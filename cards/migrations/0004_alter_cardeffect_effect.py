# Generated by Django 4.2.1 on 2023-06-07 15:11

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('cards', '0003_cardeffect'),
    ]

    operations = [
        migrations.AlterField(
            model_name='cardeffect',
            name='effect',
            field=models.CharField(max_length=20),
        ),
    ]
