# Generated by Django 4.1 on 2022-10-14 17:32

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api_rest', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='utilisateur',
            name='numero_national',
            field=models.CharField(default=1, max_length=50, unique=True),
            preserve_default=False,
        ),
    ]