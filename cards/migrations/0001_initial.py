# Generated by Django 4.2.1 on 2023-06-06 08:54

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Card',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('card_number', models.CharField(max_length=16)),
                ('card_type', models.CharField(max_length=10)),
                ('name', models.CharField(max_length=255)),
                ('score', models.IntegerField()),
                ('command', models.CharField(max_length=200)),
            ],
        ),
    ]
