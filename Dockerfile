FROM tensorflow/tensorflow:latest-gpu

### Install glvnd
# Had a hard time with openGL working out of the box with x forwarding.
# Used https://gitlab.com/nvidia/opengl/blob/ubuntu16.04/glvnd/devel/Dockerfile as inspiration for this part
# Looks way easier in 18.04, once tensorflow gets there

COPY --from=nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04 \
            /usr/local/lib/x86_64-linux-gnu \
            /usr/local/lib/x86_64-linux-gnu

COPY --from=nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04 \
            /usr/local/share/glvnd/egl_vendor.d/10_nvidia.json \
            /usr/local/share/glvnd/egl_vendor.d/10_nvidia.json

RUN echo '/usr/local/lib/x86_64-linux-gnu' >> /etc/ld.so.conf.d/glvnd.conf && ldconfig

#ENV LD_LIBRARY_PATH /usr/local/lib/x86_64-linux-gnu${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

### End install glvnd

ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES},display


RUN apt update && apt install -y python3-pip git x11-apps python3-opengl xvfb
# mesa-utils libgl1-mesa-glx
RUN pip3 install gym pygame
# opencv-python gym-super-mario-bros

RUN git clone https://github.com/tykurtz/playground_reinforcement_learning /notebooks/playground
WORKDIR "/notebooks/playground"
COPY run_jupyter.sh /
COPY jupyter_notebook_config.py /root/.jupyter/

CMD ["./run_jupyter.sh"]