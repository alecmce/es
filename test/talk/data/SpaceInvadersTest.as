package talk.data
{
    import org.flexunit.assertThat;
    import org.hamcrest.object.equalTo;
    import org.hamcrest.object.isFalse;
    import org.hamcrest.object.isTrue;
    import org.hamcrest.object.sameInstance;

    public class SpaceInvadersTest
    {
        private var invaders:SpaceInvaders;

        [Before]
        public function before():void
        {
            invaders = new SpaceInvaders();
        }

        private function addInvader():SpaceInvader
        {
            var invader:SpaceInvader = new SpaceInvader();
            invaders.add(invader);
            return invader;
        }

        private function addInvaders(count:int):Vector.<SpaceInvader>
        {
            var list:Vector.<SpaceInvader> = new Vector.<SpaceInvader>();
            while (count--)
                list.push(addInvader());

            return list;
        }

        [Test]
        public function canAddAnInvader():void
        {
            var invader:SpaceInvader = addInvader();
            assertThat(invaders.getCount(), equalTo(1));
        }

        [Test]
        public function afterAddingInvaderHasReportsTrue():void
        {
            var invader:SpaceInvader = addInvader();
            assertThat(invaders.has(invader), isTrue());
        }

        [Test]
        public function beforeAddingInvaderThereAreZeroRows():void
        {
            assertThat(invaders.getRows(), equalTo(0));
        }

        [Test]
        public function afterAddingInvaderThereIsOneRow():void
        {
            var invader:SpaceInvader = addInvader();
            assertThat(invaders.getRows(), equalTo(1));
        }

        [Test]
        public function firstInvaderPositionSetToZeroZero():void
        {
            var invader:SpaceInvader = addInvader();
            assertThat(invader.x, equalTo(0));
            assertThat(invader.y, equalTo(0));
        }

        [Test]
        public function subsequentInvadersGoOntoFirstRow():void
        {
            var invaders:Vector.<SpaceInvader> = addInvaders(10);
            assertThat(invaders[9].y, equalTo(0));
        }

        [Test]
        public function subsequentInvadersGoOntoSubsequentColumns():void
        {
            var list:Vector.<SpaceInvader> = addInvaders(5);
            var i:int = 5;
            while (i--)
                assertThat(list[i].x, equalTo(i));
        }

        [Test]
        public function onceRowMaxIsReachedInvadersGoToNextRow():void
        {
            var count:int = invaders.getRowMax();
            var list:Vector.<SpaceInvader> = addInvaders(count + 1);
            assertThat(list[count].y, equalTo(1));
        }

        [Test]
        public function canGetInvaderByCoordinatePair():void
        {
            var list:Vector.<SpaceInvader> = addInvaders(5);
            assertThat(list[4], sameInstance(invaders.get(4, 0)));
        }

        [Test]
        public function canRemoveInvaderByReference():void
        {
            addInvaders(5);
            var invader:SpaceInvader = invaders.get(2, 0);
            invaders.remove(invader);
            assertThat(invaders.has(invader), isFalse());
        }

        [Test]
        public function canGetBoxAroundInvaders():void
        {
            addInvaders(100);
            var size:Size = invaders.getSize();
        }

        [Test]
        public function whenAllLeftMostColumnInvadersAreDeletedBoxChangesSize():void
        {
            addInvaders(100);
            for (var y:int = 0; y < 10; y++)
                invaders.remove(invaders.get(0, y));

            var size:Size = invaders.getSize();
            assertThat(size.left, equalTo(1));
        }

        [Test]
        public function whenAllRightMostColumnInvadersAreDeletedBoxChangesSize():void
        {
            addInvaders(100);
            for (var y:int = 0; y < 10; y++)
                invaders.remove(invaders.get(9, y));

            var size:Size = invaders.getSize();
            assertThat(size.right, equalTo(8));
        }

        [Test]
        public function whenAllTopMostColumnInvadersAreDeletedBoxChangesSize():void
        {
            addInvaders(100);
            for (var x:int = 0; x < 10; x++)
                invaders.remove(invaders.get(x, 0));

            var size:Size = invaders.getSize();
            assertThat(size.top, equalTo(1));
        }

        [Test]
        public function whenAllBottomMostColumnInvadersAreDeletedBoxChangesSize():void
        {
            addInvaders(100);
            for (var x:int = 0; x < 10; x++)
                invaders.remove(invaders.get(x, 9));

            var size:Size = invaders.getSize();
            assertThat(size.bottom, equalTo(8));
        }
    }
}
