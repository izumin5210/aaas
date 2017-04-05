/* @flow */
// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.
import { PureComponent } from 'react'

import run from '../run'

type Props = {
}

type State = {
  name: string
}

class Hello extends PureComponent<void, Props, State> {
  constructor(props: Props) {
    super(props)
    this.state = {
      name: 'React',
    }
  }

  state: State

  handleChange = (e: SyntheticInputEvent) => {
    this.setState({ name: e.target.value })
  }

  render() {
    const { name } = this.state;
    return (
      <p>
        Hello&nbsp;
        <input
          type="text"
          value={name}
          onChange={this.handleChange}
        />
      </p>
    )
  }
}

run(
  <Hello name="React" />,
  // $FlowFixMe
  () => document.body.appendChild(document.createElement('div')),
)
