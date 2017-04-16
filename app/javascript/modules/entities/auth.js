/* @flow */
import { createAction, handleActions } from 'redux-actions'
import { createSelector } from 'reselect'

import type { Action } from 'redux-actions'

import type { RootState, AuthState } from '../../types'

// ================================
// actions
// ================================

type SetTokenAction = Action<string, void>
const SET_TOKEN = 'auth:setToken'
const setToken = createAction(
  SET_TOKEN,
  (payload: string) => payload
)

export const actions = {
  setToken
}

// ================================
// reducer
// ================================

const initialState: AuthState = {
  token: null
}

export default handleActions({
  // $FlowFixMe
  [setToken]: (
    state: AuthState,
    action: SetTokenAction
  ) => {
    if (action.error) {
      return state
    }

    return {
      ...state,
      token: action.payload
    }
  }
}, initialState)

// ================================
// selectors
// ================================

const authSelector = ({ entities }: RootState) => entities.auth
const accessTokenSelector = createSelector(
  authSelector,
  ({ token }: AuthState) => token
)

export const selectors = {
  auth: authSelector,
  accessToken: accessTokenSelector
}
