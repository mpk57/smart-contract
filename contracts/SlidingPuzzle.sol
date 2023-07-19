// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import '@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol';
import 'hardhat/console.sol';

contract SlidingPuzzle is Initializable, ReentrancyGuardUpgradeable, OwnableUpgradeable {
  // function initialize() public initializer {
  //   __Ownable_init();
  // }

  // struct PlayerInfo {
  //   address wallet;
  //   uint256 score;
  // }

  // struct CardObject {
  //   uint256 number;
  //   string status;
  //   bool open;
  //   uint256 value;
  // }
  // PlayerInfo[] public leaderBoard;
  // event CardsOpened(bool open1, uint256 value1, bool open2, uint256 value2);
  // mapping(address => uint256) public walletStep;

  // mapping(address => CardObject[]) public walletCardLists; // Mapping of wallet addresses to card lists

  // function makeArrayDefault(address wallet) public {
  //   CardObject[] storage cardListRecent = walletCardLists[wallet];

  //   // Clear the existing array by removing each element
  //   while (cardListRecent.length > 0) {
  //     cardListRecent.pop();
  //   }

  //   // Initialize the array with new default values
  //   for (uint256 i = 0; i < 24; i++) {
  //     uint256 value = ((i % 12)) + 1; // Calculate the value based on the card index

  //     cardListRecent.push(CardObject(i, 'down', false, value));
  //   }
  // }

  // function shuffleValues(address wallet) public returns (CardObject[] memory) {
  //   require(wallet != address(0), 'Address cannot be the zero address.');
  //   CardObject[] storage cardListRecent = walletCardLists[wallet];
  //   uint256 cardCount = cardListRecent.length;
  //   if (cardCount == 0) {
  //     makeArrayDefault(wallet); // Create the default card values if the array is empty
  //     cardCount = cardListRecent.length; // Update the card count
  //   }
  //   walletStep[wallet] = 0;
  //   // Check if wallet already exists in the leaderboard
  //   bool walletExists = false;
  //   for (uint256 i = 0; i < leaderBoard.length; i++) {
  //     if (leaderBoard[i].wallet == wallet) {
  //       walletExists = true;
  //       break;
  //     }
  //   }

  //   // Add wallet to leaderboard if it doesn't exist
  //   if (!walletExists) {
  //     leaderBoard.push(PlayerInfo(wallet, 0));
  //   }
  //   uint256[] memory indices = new uint256[](cardCount);
  //   uint256[] memory values = new uint256[](cardCount);

  //   // Store the original indices and values in separate arrays
  //   for (uint256 i = 0; i < cardCount; i++) {
  //     indices[i] = i;
  //     values[i] = cardListRecent[i].value;
  //     cardListRecent[i].open = false; // Reset the "open" attribute to false
  //   }

  //   // Shuffle the indices using Fisher-Yates algorithm
  //   for (uint256 i = cardCount - 1; i > 0; i--) {
  //     uint256 j = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, i))) % (i + 1);
  //     (indices[i], indices[j]) = (indices[j], indices[i]);
  //   }

  //   // Assign shuffled values back to the cardListRecent array
  //   for (uint256 i = 0; i < cardCount; i++) {
  //     cardListRecent[i].value = values[indices[i]];
  //     // cardListRecent[i].status = "down"; // reset 'status' attribute to down
  //   }
  // }

  // function checkAndOpenCards(address wallet, uint256 number1, uint256 number2) public returns (CardObject memory, CardObject memory) {
  //   require(wallet != address(0), 'Address cannot be the zero address.');
  //   require(number1 != number2, 'Numbers are the same.');

  //   CardObject[] storage cardListRecent = walletCardLists[wallet];
  //   CardObject memory obj1;
  //   CardObject memory obj2;
  //   // cardListRecent[number1].status = "up";
  //   // cardListRecent[number2].status = "up";
  //   for (uint256 i = 0; i < cardListRecent.length; i++) {
  //     if (cardListRecent[i].number == number1 || cardListRecent[i].number == number2) {
  //       // Check if the values of the objects are the same
  //       if (cardListRecent[number1].value == cardListRecent[number2].value) {
  //         cardListRecent[i].open = true;
  //         if (cardListRecent[i].number == number1) {
  //           obj1 = cardListRecent[i];
  //         } else {
  //           obj2 = cardListRecent[i];
  //         }
  //       }
  //       obj1 = cardListRecent[number1];
  //       obj2 = cardListRecent[number2];
  //     }
  //   }

  //   walletStep[wallet]++;

  //   // Check if all cards are open for the wallet
  //   bool allOpen = true;
  //   for (uint256 i = 0; i < cardListRecent.length; i++) {
  //     if (!cardListRecent[i].open) {
  //       allOpen = false;
  //       break;
  //     }
  //   }

  //   if (allOpen) {
  //     // Find the wallet in the leaderboard and increase its score by 10
  //     for (uint256 i = 0; i < leaderBoard.length; i++) {
  //       if (leaderBoard[i].wallet == wallet) {
  //         leaderBoard[i].score += 10 + (10 - (walletStep[wallet] / 2));
  //         break;
  //       }
  //     }
  //   }

  //   emit CardsOpened(obj1.open, obj1.value, obj2.open, obj2.value);
  //   return (obj1, obj2);
  // }

  // function getArrayRecent(address wallet) public view returns (CardObject[] memory) {
  //   require(wallet != address(0), 'Address cannot be the zero address.');

  //   return walletCardLists[wallet];
  // }

  // function getLeaderBoard() public view returns (PlayerInfo[] memory) {
  //   uint256 totalPlayers = leaderBoard.length;
  //   uint256 numPlayersToDisplay = totalPlayers > 10 ? 10 : totalPlayers;

  //   PlayerInfo[] memory sortedLeaderBoard = new PlayerInfo[](numPlayersToDisplay);
  //   for (uint256 i = 0; i < numPlayersToDisplay; i++) {
  //     sortedLeaderBoard[i] = leaderBoard[i];
  //   }

  //   for (uint256 i = 1; i < numPlayersToDisplay; i++) {
  //     for (uint256 j = 0; j < numPlayersToDisplay - i; j++) {
  //       if (sortedLeaderBoard[j].score < sortedLeaderBoard[j + 1].score) {
  //         PlayerInfo memory temp = sortedLeaderBoard[j];
  //         sortedLeaderBoard[j] = sortedLeaderBoard[j + 1];
  //         sortedLeaderBoard[j + 1] = temp;
  //       }
  //     }
  //   }

  //   return sortedLeaderBoard;
  // }

  // function getScore(address wallet) public view returns (PlayerInfo memory) {
  //   for (uint256 i = 0; i < leaderBoard.length; i++) {
  //     if (leaderBoard[i].wallet == wallet) {
  //       return leaderBoard[i];
  //     }
  //   }
  //   // If the address is not found in the leaderboard, revert with an error message
  //   revert('Wallet does not exist in the leaderboard.');
  // }
}
