/* @flow */
import type { Dispatch as ReduxDispatch } from 'redux'
import type { Action } from 'redux-actions'

export type AuthState = {
  token: ?string,
}

export type Dispatch<P, M> = ReduxDispatch<Action<P, M>>
