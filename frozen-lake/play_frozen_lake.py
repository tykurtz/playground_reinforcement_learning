import gym

action_map = {
    'a': 0,
    's': 1,
    'd': 2,
    'w': 3
}


def play_frozen_lake():
    env = gym.make('FrozenLake8x8-v0')
    env.reset()
    env.render()

    done = False
    while not done:
        action = input('>>> ')
        if action in action_map:
            _, _, done, _ = env.step(action_map[action])
            env.render()
        else:
            print(action, " is not an acceptable input")

    env.close()


if __name__ == '__main__':
    print('Use wasd to cross the lake. The trick of the game is that there is only a 1/3rd chance that the direction '
          'you input will be used, and a 0% chance that the opposite of that direction will be used.')

    play_frozen_lake()
