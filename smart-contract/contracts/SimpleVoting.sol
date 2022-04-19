// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SimpleVoting {
    //state variables
    address public chairman; //address of chairman

    //STAKEHOLDER VARIABLES
    mapping (address => Stakeholder) public stakeholders; //hold list of all stakeholders registered
    Stakeholder [] public stakeholdersList; //hold list of all stakeholders registered

    address [] public BODList; //holds list of all board of directors registered by the Chairman
    address [] public teachersList; //holds list of all teachers registered by the Chairman
    address [] public studentList; //holds list of all students registered by the Chairman

    enum Role{ BOD, TEACHER, STUDENT }//enum to rep the possible roles an address can take

    struct Stakeholder { 
        Role role;
        bool voted;  // if true, that person already voted
        uint8 candidateChosen; // index of the candidate voted for
        address registeredAddress; //address that registered stakeholder
    } // struct of the details for each stakeholder

    Candidate [] public candidatesList; //holds list of all candidates registered by the Chairman
    struct Candidate {
        uint256 candidateID;
        bytes candidateName;
        uint8 votesReceived;
        address registeredAddress; //address that registered candidate
        /*
        uint8 votesReceivedBOD
        uint8 votesReceivedTeachers
        uint8 votesReceivedStudents
        */
    } // struct of the details for each Cabdidates  

    //Modifier
    modifier onlyByChairman() {
      require(msg.sender == chairman, "Only Chairman can do this.");
      _;
   }

    function createStakeHolder (address _address, Role _role) public onlyByChairman {
        stakeholders[_address] = Stakeholder(_role, false, 8, msg.sender);
        if (stakeholders[_address].role == Role(0)){
            BODList.push(_address);
        }
        if (stakeholders[_address].role == Role(1)){
            teachersList.push(_address);
        }
        if (stakeholders[_address].role == Role(2)){
            studentList.push(_address);
        }
    }

    function createCandidate ( string memory _candidateName) public onlyByChairman {
        uint256 candidateID;
        if (candidatesList.length == 0) {
            candidateID = 0;
        } else {
            candidateID = candidatesList.length;
        }
        bytes memory candidateName = toBytes(_candidateName);
        candidatesList.push( Candidate(candidateID, candidateName, 0, msg.sender));
    }

    constructor (){
        chairman = msg.sender;
        votingActive = false;
        resultsActive = false;
    }

    function toBytes(string memory _name) public pure returns (bytes memory) {
        return abi.encodePacked(_name);
    }

    //ENABLE AND DISABLE VOTING PROCESS ON OR OFF
    //ENABLE AND DISABLE VOTING PROCESS ON OR OFF
    //ENABLE AND DISABLE VOTING PROCESS ON OR OFF
    bool public votingActive;

    function toggleVoting () public onlyByChairman {
        if (votingActive){
            votingActive = false;
        } else {
            votingActive = true;
        }
    }



    // ENABLE VIEWING RESUTLS ON AND OFF
    // ENABLE VIEWING RESUTLS ON AND OFF
    // ENABLE VIEWING RESUTLS ON AND OFF
    bool public resultsActive;
    function toggleResult () public onlyByChairman {
        if (resultsActive){
            resultsActive = false;
        } else {
            resultsActive = true;
        }
    }
}
