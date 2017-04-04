/* @flow */
import run from '../run'
import DashboardContainer from '../containers/DashboardContainer'
import configureStore from '../store/configureStore'

const initialState = {}
const store = configureStore(initialState)
// store.runSaga(rootSaga)

run(
  <DashboardContainer />,
  () => document.querySelector('#dashboard-container'),
  { store },
)
