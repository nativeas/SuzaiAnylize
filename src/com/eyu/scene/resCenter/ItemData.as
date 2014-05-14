package com.eyu.scene.resCenter
{

    public class ItemData extends Object
    {
        private var _type:String;
        private var _view:String;
        private var _action:String;
        private var _layerSet:Object;
        private var _roleSet:String;
        private var _roleType:int;
        private var _nameX:int;
        private var _nameY:int;
        private var _speed:int;
        private var _down:Array;
        private var _rDown:Array;
        private var _right:Array;
        private var _rUp:Array;
        private var _up:Array;
        private var _offset:Object;

        public function ItemData()
        {
            this._down = [];
            this._rDown = [];
            this._right = [];
            this._rUp = [];
            this._up = [];
            return;
        }// end function

        public function get offset() : Object
        {
            return this._offset;
        }// end function

        public function set offset(param1:Object) : void
        {
            this._offset = param1;
            return;
        }// end function

        public function clone() : ItemData
        {
            var _loc_1:* = new ItemData();
            _loc_1.type = this._type;
            _loc_1.view = this._view;
            _loc_1.action = this._action;
            _loc_1.nameY = this._nameY;
            _loc_1.nameX = this._nameX;
            _loc_1.speed = this._speed;
            _loc_1.roleSet = this._roleSet;
            _loc_1.layerSet = this._layerSet;
            _loc_1.roleType = this._roleType;
            _loc_1.down = this._down;
            _loc_1.rDown = this._rDown;
            _loc_1.right = this._right;
            _loc_1.rUp = this._rUp;
            _loc_1.up = this._up;
            _loc_1.offset = this._offset;
            return _loc_1;
        }// end function

        public function destroy() : void
        {
            this._type = "";
            this._view = "";
            this._action = "";
            this._nameY = 0;
            this._nameX = 0;
            this._speed = 0;
            this._roleSet = "";
            this._layerSet = {};
            this._roleType = 0;
            this.dispose(this._down);
            this.dispose(this._rDown);
            this.dispose(this._right);
            this.dispose(this._rUp);
            this.dispose(this._up);
            this.offset = {};
            this._down = null;
            this._rDown = null;
            this._right = null;
            this._rUp = null;
            this._up = null;
            return;
        }// end function

        private function dispose(param1:Array) : void
        {
            var _loc_2:Object = null;
            for each (_loc_2 in param1)
            {
                
                if (_loc_2 && _loc_2.bmd)
                {
                    _loc_2.bmd.dispose();
                    _loc_2.bmd = null;
                    _loc_2 = null;
                }
            }
            return;
        }// end function

        public function get type() : String
        {
            return this._type;
        }// end function

        public function set type(param1:String) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get view() : String
        {
            return this._view;
        }// end function

        public function set view(param1:String) : void
        {
            this._view = param1;
            return;
        }// end function

        public function get action() : String
        {
            return this._action;
        }// end function

        public function set action(param1:String) : void
        {
            this._action = param1;
            return;
        }// end function

        public function get nameY() : int
        {
            return this._nameY;
        }// end function

        public function set nameY(param1:int) : void
        {
            this._nameY = param1;
            return;
        }// end function

        public function get nameX() : int
        {
            return this._nameX;
        }// end function

        public function set nameX(param1:int) : void
        {
            this._nameX = param1;
            return;
        }// end function

        public function get speed() : int
        {
            return this._speed;
        }// end function

        public function set speed(param1:int) : void
        {
            this._speed = param1;
            return;
        }// end function

        public function get layerSet() : Object
        {
            return this._layerSet;
        }// end function

        public function set layerSet(param1:Object) : void
        {
            this._layerSet = param1;
            return;
        }// end function

        public function get roleSet() : String
        {
            return this._roleSet;
        }// end function

        public function set roleSet(param1:String) : void
        {
            this._roleSet = param1;
            return;
        }// end function

        public function get roleType() : int
        {
            return this._roleType;
        }// end function

        public function set roleType(param1:int) : void
        {
            this._roleType = param1;
            return;
        }// end function

        public function get down() : Array
        {
            return this._down;
        }// end function

        public function set down(param1:Array) : void
        {
            this._down = param1;
            return;
        }// end function

        public function get rDown() : Array
        {
            return this._rDown;
        }// end function

        public function set rDown(param1:Array) : void
        {
            this._rDown = param1;
            return;
        }// end function

        public function get right() : Array
        {
            return this._right;
        }// end function

        public function set right(param1:Array) : void
        {
            this._right = param1;
            return;
        }// end function

        public function get rUp() : Array
        {
            return this._rUp;
        }// end function

        public function set rUp(param1:Array) : void
        {
            this._rUp = param1;
            return;
        }// end function

        public function get up() : Array
        {
            return this._up;
        }// end function

        public function set up(param1:Array) : void
        {
            this._up = param1;
            return;
        }// end function

    }
}
