from django.db import models

# Create your models here.
class Fileupload(models.Model):
    image = models.ImageField()
    file = models.FileField()