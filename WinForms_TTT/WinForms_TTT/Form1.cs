using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WinForms_TTT
{
    public partial class TicTacToe : Form
    {
        bool turn = true; // true = X turn, false = Y turn
        int turn_count = 0;

        public TicTacToe()
        {
            InitializeComponent();
        } //TicTacToe

        private void aboutToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MessageBox.Show("By David", "Tic Tac Toe About");
        } //aboutToolStripMenuItem_Click

        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Application.Exit();
        } //exitToolStripMenuItem_Click

        private void button_click(object sender, EventArgs e)
        {
            //convert sender object to type Button
            Button btn = (Button)sender;

            if (turn)
            {
                btn.Text = "X";
            }
            else
            {
                btn.Text = "O";
            }

            turn = !turn;
            btn.Enabled = false;
            turn_count++;

            checkWinner();
        } //button_click

        private void checkWinner()
        {
            bool winnerWinnerChickenDinner = false;

            // check across horizontal rows
            if ((A1.Text == A2.Text) && (A2.Text == A3.Text) && (!A1.Enabled))
            {
                winnerWinnerChickenDinner = true;
            }
            else if ((B1.Text == B2.Text) && (B2.Text == B3.Text) && (!B1.Enabled))
            {
                winnerWinnerChickenDinner = true;
            }
            else if ((C1.Text == C2.Text) && (C2.Text == C3.Text) && (!C1.Enabled))
            {
                winnerWinnerChickenDinner = true;
            }

            // check across vertical columns
            if ((A1.Text == B1.Text) && (B1.Text == C1.Text) && (!A1.Enabled))
            {
                winnerWinnerChickenDinner = true;
            }
            else if ((A2.Text == B2.Text) && (B2.Text == C2.Text) && (!A2.Enabled))
            {
                winnerWinnerChickenDinner = true;
            }
            else if ((A3.Text == B3.Text) && (B3.Text == C3.Text) && (!A3.Enabled))
            {
                winnerWinnerChickenDinner = true;
            }

            // check diaganols
            if ((A1.Text == B2.Text) && (B2.Text == C3.Text) && (!A1.Enabled))
            {
                winnerWinnerChickenDinner = true;
            }
            else if ((A3.Text == B2.Text) && (B2.Text == C1.Text) && (!C1.Enabled))
            {
                winnerWinnerChickenDinner = true;
            }

            // set winner to correct player
            if (winnerWinnerChickenDinner)
            {
                // disable all buttons 
                disableButton();

                // find out which turn the winner is
                String winner = "";
                if (turn)
                {
                    winner = "O";
                    OWinCnt.Text = (Int32.Parse(OWinCnt.Text) + 1).ToString();
                }
                else
                {
                    winner = "X";
                    XWinCnt.Text = (Int32.Parse(XWinCnt.Text) + 1).ToString();
                };
                MessageBox.Show(winner + " Won!!!", "YAAAS");
            }
            else
            {
                if (turn_count == 9)
                {
                    MessageBox.Show("Boo", "It was a tie...");
                    DrawCnt.Text = (Int32.Parse(DrawCnt.Text) + 1).ToString();
                }
            }
        } //checkWinner

        private void disableButton()
        {
            try
            {
                foreach (Control ctrl in Controls)
                {
                    Button btn = (Button)ctrl;
                    btn.Enabled = false;
                }
            }

            catch { }

        } //disableButton

        private void newGameToolStripMenuItem_Click(object sender, EventArgs e)
        {
            // default to x's turn
            turn = true;

            // reset turn count
            turn_count = 0;

            foreach (Control ctrl in Controls)
            {
                try
                {
                    Button btn = (Button)ctrl;
                    btn.Enabled = true;
                    btn.Text = "";
                }

                catch { }
            }
        } //newGameToolStripMenuItem_Click

        private void button_enter(object sender, EventArgs e)
        {
            Button btn = (Button)sender;

            if (btn.Enabled)
            {
                if (turn)
                {
                    btn.Text = "X";
                }
                else
                {
                    btn.Text = "O";
                }
            }
        } //button_enter

        private void button_leave(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            if (btn.Enabled)
            {
                btn.Text = "";
            }
        } //button_leave

        private void resetCountToolStripMenuItem_Click(object sender, EventArgs e)
        {
            OWinCnt.Text = "0";
            XWinCnt.Text = "0";
            DrawCnt.Text = "0";
        } //resetCountToolStripMenuItem_Click

        private void resetGameToolStripMenuItem_Click(object sender, EventArgs e)
        {
            // default to x's turn
            turn = true;

            // reset turn count
            turn_count = 0;

            foreach (Control ctrl in Controls)
            {
                try
                {
                    Button btn = (Button)ctrl;
                    btn.Enabled = true;
                    btn.Text = "";
                }

                catch { }
            }
        } //resetGameToolStripMenuItem_Click
    }
}
