import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank {
  stable var currentValue: Float = 300;
  //currentValue := 100;

  stable var start = Time.now();
  let id = 1234;
  //Debug.print(debug_show(currentValue));

  Debug.print(debug_show(currentValue));
  public func topUp(amount: Float) {
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };

  public func withdrawal(amount: Float) {
    let temp: Float = currentValue - amount;
    if(temp >= 0) {
      currentValue -= amount;
      Debug.print(debug_show(currentValue));
    } else {
      Debug.print("Withdrawl amount is greater than current value");
    }
  };

  public query func checkBalance() : async Float {
    return currentValue;
  };

  public func compound() {
    let current = Time.now();
    let elapsed = (current - start)/1000000000;
    currentValue := currentValue * (1.01 ** Float.fromInt(elapsed));
    start := current;
  }
  //topUp();
}