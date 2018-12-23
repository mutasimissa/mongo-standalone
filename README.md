## mongo-standalone
Shell script to start a standalone instance of mongod with specified port and path

### How to?
> Prepare: 
- make sure you have mongodb community server is installed on the system
```sh
mongod --version
```

- copy the script into the direcotry that your database(s) will be stored on your machine

- if you have already the database, create the required directories DB/databases then copy your database to the newely created directory:
```sh
mkdir DB
mkdir DB/databases
cp YOUR_DATABASE_DATA_PATH DB/databases
```

- if you want to create a new database then skip to the next step, you don't need to create directories, the script will create it for you!

- give the script execution permissions
```sh
chmod +x start_mongod.sh
```

> Start: 

- start the script, recommended not to use sudo or root user, also note that the script runner user should own the directory the script placed in.
```sh
./start_mongod.sh
```
- the script will create a new directory *DB* in the same directory of the script

> Auth: The script accept the argument *auth* if the instance requires authentication *(requires a user in admin database see the manual:https://docs.mongodb.com/manual/tutorial/enable-authentication/)*
```sh
./start_mongod.sh auth
```
> The script was made for testing and development purposes, also it's very basic and made for my personal workflow on a MEAN project, it shouldn't be used in production environments at all!

#### Questions
> For any questions regarding the practice open a new issue [here](https://github.com/mutasimissa/mongo-standalone/issues)
### License
The project is licensed under the [GNU GPL V3](https://www.gnu.org/licenses/gpl-3.0.en.html)
##### GOOD LUCK!

Powered by: [Sourcya](https://sourcya.com)
