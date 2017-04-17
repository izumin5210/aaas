/* @flow */
import { Component } from 'react'
import { connect } from 'react-redux'

import { actions as authActions } from '../modules/entities/auth'
import { actions as appsActions } from '../modules/entities/applications'

import Page from '../components/dashboard/Page'
import Section from '../components/dashboard/Section'
import SectionHeader from '../components/dashboard/SectionHeader'
import ApplicationList from '../components/dashboard/ApplicationList'

import type { Connector } from 'react-redux'
import type { Dispatch, RootState, ApplicationsState } from '../types'

type RequiredProps = {
}

type InjectedProps = {
  applications: ApplicationsState,
  setToken: (token: string) => any,
  fetchApps: () => any,
}

type Props = RequiredProps & InjectedProps

const connector: Connector<RequiredProps, Props> = connect(
  (state: RootState) => ({
    applications: state.entities.applications
  }),
  (dispatch: Dispatch<any, any>) => ({
    setToken: (token: string) => dispatch(authActions.setToken(token)),
    fetchApps: () => dispatch(appsActions.fetchApplications())
  })
)

class DashboardContainer extends Component<void, Props, void> {
  // for lint
  props: Props

  componentDidMount () {
    const el = document.querySelector('meta[name=access-token]')
    if (el != null) {
      const token = el.getAttribute('content')
      if (token != null) {
        this.props.setToken(token)
        this.props.fetchApps()
      }
    }
  }

  render () {
    const { applications } = this.props
    return (
      <Page>
        <Section>
          <SectionHeader
            title='Applications'
            icon='cubes'
          />
          <ApplicationList
            {...{ applications }}
          />
        </Section>
      </Page>
    )
  }
}

export default connector(DashboardContainer)
