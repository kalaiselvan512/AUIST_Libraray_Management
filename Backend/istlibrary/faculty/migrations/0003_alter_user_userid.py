# Generated by Django 3.2.6 on 2022-05-10 07:37

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('faculty', '0002_auto_20220510_1253'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='userid',
            field=models.UUIDField(primary_key=True, serialize=False, unique=True),
        ),
    ]
