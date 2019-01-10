FROM tensorflow/tensorflow:latest-gpu

COPY --from=nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04 /usr/local/lib/x86_64-linux-gnu /usr/local/lib/x86_64-linux-gnu
COPY --from=nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04 /usr/local/lib/i386-linux-gnu /usr/local/lib/i386-linux-gnu

# COPY --from=nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04 /usr/local/share/glvnd/egl_vendor.d/10_nvidia.json /usr/local/share/glvnd/egl_vendor.d/10_nvidia.json

RUN echo '/usr/local/lib/x86_64-linux-gnu' >> /etc/ld.so.conf.d/glvnd.conf && \
    echo '/usr/local/lib/i386-linux-gnu' >> /etc/ld.so.conf.d/glvnd.conf && \
    ldconfig

ENV LD_LIBRARY_PATH /usr/local/lib/x86_64-linux-gnu:/usr/local/lib/i386-linux-gnu${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES},display


RUN apt update && apt install -y python3-pip git x11-apps python3-opengl mesa-utils libgl1-mesa-glx
RUN pip3 install opencv-python jupyter gym
# gym-super-mario-bros

RUN git clone https://github.com/tykurtz/playground_reinforcement_learning /notebooks/playground
WORKDIR "/notebooks/playground"


CMD ["python3", "./cart-pole/play_cart_pole.py"]
#CMD ["glxgears", "-info"]