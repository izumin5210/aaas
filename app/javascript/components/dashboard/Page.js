/* @flow */
import { PureComponent } from 'react'
import type { Children } from 'react'

type Props = {
  children: Children,
}

export default class Page extends PureComponent<void, Props, void> {
  render () {
    const { children } = this.props
    return (
      <div className='Dashboard'>
        <div className='Dashboard__main'>
          { children }
        </div>
      </div>
    )
  }
}
