let text = React.string
type props = unit

module T: Browser.Sandbox = {
  type msg =
    | Add
    | Remove

  type model = {value: int}

  let initialModel = {
    value: 0,
  }

  let update = (model, msg) =>
    switch msg {
    | Add => {value: model.value + 1}
    | Remove => {value: model.value - 1}
    }

  let button = (action, textValue) => <button onClick={action}>{text(textValue)}</button>

  let view = (dispatch, model, _props) => {
    <div>
      <h1> {text("Actual value: " ++ string_of_int(model.value))} </h1>
      {button(_ => dispatch(Add), "Add")}
      <button onClick={_ => dispatch(Remove)}> {text("Remove")} </button>
    </div>
  }
}

let make = props => Browser.useSandbox(module(T))(props)
@obj external makeProps: unit => props = ""
