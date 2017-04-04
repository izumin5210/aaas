/* @flow */
import run from '../run'
import DashboardContainer from '../containers/DashboardContainer'
import configureStore from '../store/configureStore'

import { rootSaga } from '../modules'

const initialState = {}
const store = configureStore(initialState)
store.runSaga(rootSaga)

run(
  <DashboardContainer />,
  () => document.querySelector('#dashboard-container'),
  { store },
)
