/* @flow */
import { createAction, handleActions } from 'redux-actions'

import type { Action } from 'redux-actions'

import type { AuthState } from '../types'

// ================================
// actions
// ================================

export type SetTokenAction = Action<string, void>
const SET_TOKEN = 'auth:setToken'
export const setToken = createAction(
  SET_TOKEN,
  (payload: string) => payload,
)


// ================================
// reducer
// ================================

const initialState: AuthState = {
  token: null,
};

export default handleActions({
  [((setToken : any): string)]: (state: AuthState, { payload }: SetAuthAction) => {
    return {
      ...state,
      token: payload,
    }
  },
}, initialState)
