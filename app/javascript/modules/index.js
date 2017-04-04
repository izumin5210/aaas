/* @flow */
import { combineReducers } from 'redux'
import { fork } from 'redux-saga/effects'

import type { IOEffect } from 'redux-saga/effects'

import entities, { entitiesSaga } from './entities'

export default combineReducers({
  entities,
})

export function* rootSaga(): Generator<IOEffect, *, *> {
  yield [
    fork(entitiesSaga),
  ]
}
