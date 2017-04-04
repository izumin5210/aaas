/* @flow */
import { createAction, handleActions } from 'redux-actions'
import { OrderedMap } from 'immutable'

import type { Action } from 'redux-actions'
import type { List } from 'immutable'

import type { ApplicationsState } from '../../types'
import type { Application } from '../../entities/Application'

// ================================
// actions
// ================================

export type AddApplicationsAction = Action<List<Application>, void>
const ADD_APPLICATIONS = 'applications:add'
export const addApplications = createAction(
  ADD_APPLICATIONS,
  (payload: List<Application>) => payload,
)

const FETCH_APPLICATIONS = 'applications:fetch'
export const fetchApplications = createAction(FETCH_APPLICATIONS)


// ================================
// reducer
// ================================

const initialState: ApplicationsState = OrderedMap()

export default handleActions({
  [((addApplications: any): string)]: (
    state: ApplicationsState,
    { payload }: AddApplicationsAction
  ) => payload.reduce((s, a) => s.set(a.id, a), state),
}, initialState)
