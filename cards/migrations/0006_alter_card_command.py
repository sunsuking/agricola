# Generated by Django 4.2.1 on 2023-06-07 18:48

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('cards', '0005_alter_cardeffect_command'),
    ]

    operations = [
        migrations.AlterField(
            model_name='card',
            name='command',
            field=models.CharField(max_length=200, null=True),
        ),
    ]
