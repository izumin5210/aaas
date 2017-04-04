/* @flow */
import type { Map } from 'immutable'
import type {
  Dispatch as ReduxDispatch,
  Store as ReduxStore,
} from 'redux'
import type { Action } from 'redux-actions'

export type AuthState = {
  +token: ?string,
}

export type EntitiesState = {
  +auth: AuthState,
}

export type RootState = {
  +entities: EntitiesState,
}

export type RootStore = ReduxStore<RootState, Action<any, any>>

export type Dispatch<P, M> = ReduxDispatch<Action<P, M>>
