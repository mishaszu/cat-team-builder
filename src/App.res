@val external setTimeout: (unit => unit, int) => unit = "setTimeout"
type props = unit

type model = int

type msg =
  | Add
  | Remove
  | Set(int)

type actionBuilder = {
  add: ReactEvent.Mouse.t => unit,
  remove: ReactEvent.Mouse.t => unit,
  set: int => unit,
}

let actionsBuilder = dispatch => {
  add: _ => dispatch(Add),
  remove: _ => dispatch(Remove),
  set: value => dispatch(Set(value)),
}

let update = (state, action) => {
  switch action {
  | Add => state + 1
  | Remove => state - 1
  | Set(value) => value
  }
}

let view = (~model, ~props, ~actions) =>
  <div>
    <h1> {("Value: " ++ model->string_of_int)->React.string} </h1>
    <button onClick={actions.add}> {"Add"->React.string} </button>
    <button onClick={actions.remove}> {"Remove"->React.string} </button>
  </div>

let useEffects = (~model, ~props, ~actions) => {
  React.useEffect0(() => {
    setTimeout(() => {
      actions.set(30)
    }, 2000)
    None
  })
  React.useEffect1(() => {
    if model == 10 || model == -10 {
      actions.set(0)
    }
    None
  }, [model])
}

let make = props => {
  let (model: model, dispatch) = React.useReducer(update, 0)
  let actions = React.useMemo0(() => actionsBuilder(dispatch))
  useEffects(~model, ~props, ~actions)
  view(~model, ~props, ~actions)
}

@obj external makeProps: unit => props = ""
