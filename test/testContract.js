const testing = artifacts.require("testingContract") ;
  
contract("testingContract1" , () => {
    it("Test Contract Testing" , async () => {
       const contractTest = await testing.deployed() ;
       await contractTest.upDateName("MaverickMarvel") ;
       const result = await contractTest.name() ;
       assert(result === "MaverickMarvel") ;
    });
});