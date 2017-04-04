/* @flow */
import { combineReducers } from 'redux'
import { fork } from 'redux-saga/effects'

import type { IOEffect } from 'redux-saga/effects'

import auth from './auth'
import applications from './applications'

import applicationsSaga from './applications-saga'

export default combineReducers({
  auth,
  applications,
})

export function* entitiesSaga(): Generator<IOEffect, *, *> {
  yield [
    fork(applicationsSaga),
  ]
}
