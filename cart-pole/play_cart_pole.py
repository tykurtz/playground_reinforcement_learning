import gym
from pyglet.window import key
import pygame


def play_cart_pole(fps=30):
    fps = 30

    env = gym.make('CartPole-v0')
    env.reset()
    env.render()

    # Setup callback to capture keys being pressed
    keys = key.KeyStateHandler()
    env.env.viewer.window.push_handlers(keys)

    clock = pygame.time.Clock()

    action = env.action_space.sample()
    while True:
        if keys[key.RIGHT]:
            action = 1
        if keys[key.LEFT]:
            action = 0
        if keys[key.SPACE]:
            env.reset()
        if keys[key.Q]:
            break

        _, _, done, _ = env.step(action)
        env.render()
        clock.tick(fps)

    env.close()


if __name__ == '__main__':
    print('Use the left and right arrows to try to balance the inverted pendulum. Use space to reset the environment'
          ' and q to quit')

    play_cart_pole()
