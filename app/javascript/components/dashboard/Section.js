/* @flow */
import { PureComponent } from 'react'
import type { Children } from 'react'

type Props = {
  children?: Children,
}

export default class Section extends PureComponent<void, Props, void> {
  // for lint
  props: Props

  render () {
    const { children } = this.props
    return (
      <section className='Dashboard__section'>
        { children }
      </section>
    )
  }
}
