from django.contrib import admin

from .models import *

from django.contrib.auth.admin import UserAdmin
# from .models import User


UserAdmin.list_display = ('username', 'is_staff',
                'is_active', 'is_association', 'equipe_secours', 'motard', 'client')

UserAdmin.fieldsets += ('Custom fields set', {'fields': ('is_association', 'equipe_secours', 'motard', 'client')}),


admin.site.register(Ceni)
admin.site.register(CustomUser, UserAdmin)
admin.site.register(EquipeSecours)
admin.site.register(MembreEquipeSecours)
admin.site.register(Utilisateur)
admin.site.register(Association)
admin.site.register(Parking)
admin.site.register(Motard)
admin.site.register(Client)
admin.site.register(Course)
admin.site.register(Alerte)
admin.site.register(Intervention)


