/* @flow */
import { Component } from 'react'
import { connect } from 'react-redux'

import { setToken } from '../modules/entities/auth'

import type { Connector } from 'react-redux'
import type { Dispatch } from '../types'

type RequiredProps = {
}

type InjectedProps = {
  setToken: (token: string) => any,
}

type Props = RequiredProps & InjectedProps

const connector: Connector<RequiredProps, Props> = connect(
  () => ({}),
  (dispatch: Dispatch<any, any>) => ({
    setToken: (token: string) => dispatch(setToken(token)),
  }),
)

class DashboardContainer extends Component<void, Props, void> {
  constructor(props: Props) {
    super(props)
  }

  componentDidMount() {
    const el = document.querySelector('meta[name=access-token]')
    if (el != null) {
      const token = el.getAttribute('content')
      if (token != null) {
        this.props.setToken(token)
      }
    }
  }

  render() {
    return (
      <h1>dashboard</h1>
    )
  }
}

export default connector(DashboardContainer)
