package alecmce.console.model
{
    import org.flexunit.assertThat;
    import org.hamcrest.object.equalTo;

    public class ActionHistoryTest
    {
        private var history:ActionHistory;

        [Before]
        public function before():void
        {
            history = new ActionHistory();
        }

        [Test]
        public function canAddHistory():void
        {
            history.add("test");
            assertThat(history.length, equalTo(1));
        }

        [Test]
        public function canGetPreviousItem():void
        {
            history.add("test");
            assertThat(history.getPrevious(), equalTo("test"));
        }

        [Test]
        public function addTwoItemsAndGetPreviousTwiceRetrievesFirstItem():void
        {
            history.add("line1");
            history.add("line2");
            history.getPrevious();
            assertThat(history.getPrevious(), equalTo("line1"));
        }

        [Test]
        public function getPreviousReturnsBlankAtEndOfItems():void
        {
            assertThat(history.getPrevious(), equalTo(""));
        }

        [Test]
        public function getNextReturnsBlankLineWhenNothingToShow():void
        {
            assertThat(history.getNext(), equalTo(""));
        }

        [Test]
        public function getNextTraversesHistoryOppositeToGetNext():void
        {
            history.add("line1");
            history.add("line2");
            history.getPrevious();
            history.getPrevious();
            assertThat(history.getNext(), equalTo("line2"));
        }
    }
}