/* @flow */
import { Provider } from 'react-redux'

import type { Element } from 'react'

let DevTools = null
if (process.env.NODE_ENV !== 'production') {
  DevTools = require('./DevTools').default
}

type Props = {
  children?: Element<any>,
  store: ?Object,
}

export default function Root ({ children, store }: Props) {
  if (store == null) {
    return children
  }

  return (
    <Provider store={store}>
      <div className='Root'>
        { DevTools != null && <DevTools /> }
        { children }
      </div>
    </Provider>
  )
}
