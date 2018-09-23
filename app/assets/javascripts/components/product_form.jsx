class ProductForm extends React.Component {
  render() {
    return (
      <div>
        <h2>Welcome friend!</h2>
        <form action='/products' method='post'>
          <label>Enter the ASIN:</label>
          <input
            type="text"
            name="asin"
          />
          <input type="submit" />
        </form>
      </div>
    )    
  }
}