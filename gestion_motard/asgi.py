"""
ASGI config for gestion_motard project.

It exposes the ASGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/4.0/howto/deployment/asgi/
"""

import os

from django.core.asgi import get_asgi_application

# for channels
from channels.auth import AuthMiddlewareStack
from channels.routing import ProtocolTypeRouter, URLResolver
from channels.security.websocket import AllowedHostsOriginValidator

import api_rest.routing
from django.urls import path


os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'gestion_motard.settings')

django_asgi_app = get_asgi_application()

# for channels
application = ProtocolTypeRouter({
    "http": django_asgi_app,
    # "websocket": URLResolver(websocket_urlpatterns),
    # "websocket": AllowedHostsOriginValidator(
    #         AuthMiddlewareStack(URLRouter([api_rest.routing.websocket_urlpatterns]))
    #     ),
    "websocket": AuthMiddlewareStack(
        URLRouter([
            path("ws/", api_rest.routing.websocket_urlpatterns, name="ws"),
        ])
    ),
})
