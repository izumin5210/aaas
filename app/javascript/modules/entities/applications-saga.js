/* @flow */
import { call, cancel, fork, put, select, take, takeEvery } from 'redux-saga/effects'
import type { CallEffect, IOEffect, PutEffect, SelectEffect } from 'redux-saga/effects'

import {
  actions
} from './applications'

import {
  selectors
} from './auth'

import {
  FetchApplicationRequest
} from '../../services'

function * handleFetchApplications (): Generator<CallEffect | PutEffect | SelectEffect, *, *> {
  const token = yield select(selectors.accessToken)

  if (token == null) {
    return
  }

  const req = yield call(FetchApplicationRequest.execute, { token })

  yield put(actions.addApplications(req.applications))
}

function * watchFetchApplications (): Generator<IOEffect, *, *> {
  yield takeEvery(actions.fetchApplications, handleFetchApplications)
}

export default function * (): Generator<IOEffect, *, *> {
  yield [
    fork(watchFetchApplications)
  ]
}
