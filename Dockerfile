FROM tensorflow/tensorflow:latest-gpu

RUN apt-get update && apt-get install python3-pip git -y
RUN pip3 install opencv-python jupyter gym # gym-super-mario-bros

RUN git clone https://github.com/tykurtz/playground_reinforcement_learning
