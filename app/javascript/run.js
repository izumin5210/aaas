/* @flow */
import { render } from 'react-dom';

import './setup';
import Root from './containers/Root';

import type { Element } from 'react'

type Options = {
  store?: Object,
}

if (process.env.NODE_ENV !== 'production') {
  require('react-hot-loader/patch')
}

export default function run(
  children: Element<any>,
  getElement: () => ?HTMLElement,
  { store }: Options = {},
) {
  const getRoot = () => (
    <Root {...{ store }}>
      { children }
    </Root>
  )

  const impl = () => {
    if (process.env.NODE_ENV === 'production') {
      render(
        getRoot(),
        getElement(),
      )
    } else {
      const { AppContainer } = require('react-hot-loader')
      const mount = () => {
        render(
          <AppContainer>
            { getRoot() }
          </AppContainer>,
          getElement(),
        )
      }

      mount()

      if (module.hot) {
        // $FlowFixMe
        module.hot.accept('./containers/Root', mount)
      }
    }
  }

  document.addEventListener('DOMContentLoaded', impl)
}
