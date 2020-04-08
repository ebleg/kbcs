# A Reinforcement Learning - Based Architecture for Fuzzy Logic Control
## Knowledge-based Control Systems - Reproduction Assignment

*by Bart Kevers, Britt Krabbenborg, Maxime Croft & Emiel Legrand*

To run the code, run `main.m`. All the controller functionality is implemented in the ARIC class. The fuzzification and defuzzification methods can be found in the `fuzzyInference` folder. 

## Project structure
- `doc` additional documentation on the project
- `old` code written before final integration
- `tools` general purpose functions, e.g. numerical methods etc
- `data` parameters files
- `fuzzyInference` code for the implementation of Fuzzy Logic in the controller, i.e. the fuzzy rules, inference etc.

## Code documentation

### `main.m`
Main script, which has to be executed in order to test the ARIC controller. In short, it performs the following actions: 
1. Load parameters from the `parameters.mat` file. Contains both the parameters of the physical cart-pole system and the learning settings for the ARIC controller. 
2. The nonlinear cart-pole system is linearized for verification purposes and to develop an LQR-controller for comparison. To do so, two Jacobian matrices are computed by means of the existing `jacobianest.m` routine
   
   A = df(x, u)/(dx) | x=0, u=0
   
   B = df(x, u)/du | x=0, u=0


3. LQR controller based on the linearized system. Not used for now.
4. First, an instance of the ARIC class is constructed to represent the controller. The testing of the ARIC control basically happens in two nested `while` loops, i.e.
   - The inner loop simulates the dynamic system with the ARIC controller providing the input in the system. Integration of the dynamics is done with the Classic Runge-Kutta method (RK4) whose implementation is located in `tools`. After every integration step the state is checked against the failure conditions. If these are met, the 'try' is over and the simulation starts again.
   - The outer loop repeats when the simulation reaches a failure condition. The states are reinitialized to their original condition. The controller however remembers its state since it has to learn over multiple tries. 

 ### `ARIC.m`
 The reason why the controller is implemented as a class rather than a function is to incorporate some form of persistent memory in order to accomodate learning (because the controller is continuously self-adapting). 

#### General

##### `obj = ARIC(param)`
Constructor method. All the settings for the learning process are read from the `param` struct. Weight matrices are initialized randomly. Please note that the weight vectors are stored as row vectors to facilitate matrix multiplication without transposing.

##### `F = getControllerOutput(obj, x)`
Method that computes the output of the controller based on its state. All other methods of the class are in directly or indirectly called from this method. 

#### Action Evaluation Network

##### `[y, v] = stateEvaluation(obj, x)`
Implementation of Maxime's AEN1 function; it represents the evaluation network of the AEN. Outputs are both `y` and `v` since they are both necessary to update `A`, `b` and `c`. 

#####  `rhat = internalReinforcement(obj, x, vNew)`
Implementation of Maxime's AEN2 function. 