This is the second attempt to creat a dockerized goa env.

Steps to run the container.
1. Clone the repo.
2. run ./run.sh
3. This will create the generated code for Goa example inside the container and you should be inside the container.
4. You should then be able to edit the calc.go file as per the example in Vim.
5. After editing run 
    ```go
        go install ./cmd/calc
    ```
6. Then run 
    ```bash
        calc &
    ```
7. Pressing Ctrl + C should give you the prompt back do not worry about the warnings.
8. Running 
    ```bash
    curl localhost:8000/add/1/3
    ```
    should give 4 as the result.