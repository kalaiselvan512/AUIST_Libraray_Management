# Generated by Django 4.0.4 on 2022-06-15 11:20

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Book',
            fields=[
                ('bookid', models.CharField(max_length=20, primary_key=True, serialize=False)),
                ('title', models.CharField(max_length=200)),
                ('author1', models.CharField(max_length=200)),
                ('author2', models.CharField(max_length=200)),
                ('author3', models.CharField(max_length=200)),
                ('edition', models.CharField(max_length=100)),
                ('publisher', models.CharField(max_length=100)),
                ('domain', models.CharField(max_length=100)),
                ('status', models.CharField(choices=[('Available', 'Available'), ('Not Available', 'Not Available')], default='Available', help_text='Book availability', max_length=20)),
                ('rack', models.CharField(max_length=5)),
            ],
            options={
                'ordering': ['bookid'],
            },
        ),
        migrations.CreateModel(
            name='BookInstance',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('bookid', models.CharField(max_length=20)),
                ('title', models.CharField(max_length=200)),
                ('date', models.DateField()),
                ('borrower', models.CharField(max_length=20)),
                ('status', models.CharField(choices=[('Available', 'Available'), ('Not Available', 'Not Available')], max_length=20)),
            ],
            options={
                'ordering': ['date'],
            },
        ),
        migrations.CreateModel(
            name='Librarian',
            fields=[
                ('userid', models.CharField(max_length=20, primary_key=True, serialize=False)),
                ('password', models.CharField(max_length=50)),
            ],
        ),
        migrations.CreateModel(
            name='LibUser',
            fields=[
                ('userid', models.CharField(max_length=20, primary_key=True, serialize=False)),
                ('username', models.CharField(max_length=100)),
                ('email', models.CharField(max_length=100)),
                ('designation', models.CharField(max_length=100)),
                ('contact', models.CharField(max_length=10)),
                ('password', models.CharField(max_length=50)),
            ],
            options={
                'ordering': ['-userid'],
            },
        ),
        migrations.CreateModel(
            name='Renewal',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('bookid', models.CharField(max_length=20)),
                ('title', models.CharField(max_length=200)),
                ('date', models.DateField()),
                ('borrower', models.CharField(max_length=20)),
                ('status', models.CharField(choices=[('Available', 'Available'), ('Not Available', 'Not Available')], max_length=20)),
                ('return_date', models.DateField()),
            ],
            options={
                'ordering': ['date'],
            },
        ),
    ]
