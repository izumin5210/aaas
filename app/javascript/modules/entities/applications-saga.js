/* @flow */
import { call, cancel, fork, put, select, take, takeEvery } from 'redux-saga/effects';
import type { CallEffect, IOEffect, PutEffect, SelectEffect } from 'redux-saga/effects';

import {
  fetchApplications,
} from './applications'

function* handleFetchApplications(): Generator<*, *, *> {
}

function* watchFetchApplications(): Generator<IOEffect, *, *> {
  yield takeEvery(fetchApplications, handleFetchApplications);
}

export default function* (): Generator<IOEffect, *, *> {
  yield [
    fork(watchFetchApplications),
  ];
}
