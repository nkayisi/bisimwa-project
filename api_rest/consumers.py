from .models import Course

from .serializer import CourseSerializer


from djangochannelsrestframework.generics import GenericAsyncAPIConsumer
from djangochannelsrestframework.mixins import (
    ListModelMixin,
RetrieveModelMixin,
PatchModelMixin,
UpdateModelMixin,
CreateModelMixin,
DeleteModelMixin,
)
from djangochannelsrestframework.observer import model_observer
from djangochannelsrestframework import permissions




class CourseConsumer(
    ListModelMixin,
RetrieveModelMixin,
PatchModelMixin,
UpdateModelMixin,
CreateModelMixin,
DeleteModelMixin,
    GenericAsyncAPIConsumer
    ):
    
    queryset = Course.objects.all()
    serializer_class = CourseSerializer
    permission_classes = (permissions.AllowAny())


    async def connect(self, **kwargs):
        
        await self.course_model_change.subscribe()
        await super().connect()


    @model_observer(Course)
    async def course_model_change(self, message, observer=None, **kwargs):
        
        await self.send_jason(message)


    @course_model_change.serializer
    def course_model_serializer(self, instance, action, **kwargs):
        
        return dict (CourseSerializer(instance=instance).data, action=action.value)