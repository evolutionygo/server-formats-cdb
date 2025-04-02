--クリアー・ワールド
--Clear World
function c33900648.initial_effect(c)
	local fc33900648=c:GetFieldID()
	local copying=c:IsStatus(STATUS_COPYING_EFFECT)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--Maintenance cost: Pay 500 LP or destroy this card
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc33900648(c33900648,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_FZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(function(e,tp) return Duel.IsTurnPlayer(tp) end)
	e1:SetOperation(c33900648.maintop)
	c:RegisterEffect(e1)
	--● LIGHT: Play with your hand revealed at all times
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_PUBLIC)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_HAND,LOCATION_HAND)
	e2:SetTarget(function(e,c) return c33900648.PlayerIsAffectedByClearWorld(c:GetControler(),ATTRIBUTE_LIGHT) end)
	c:RegisterEffect(e2)
	--● DARK: If you control 2 or more monsters, you cannot declare an attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e3:SetRange(LOCATION_FZONE)
	e3:SetTargetRange(1,0)
	e3:SetCondition(c33900648.darkconyou)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCondition(c33900648.darkconopp)
	e4:SetTargetRange(0,1)
	c:RegisterEffect(e4)
	--● EARTH: Destroy 1 face-up Defense Position monster you control
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringc33900648(c33900648,1))
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e5:SetRange(LOCATION_FZONE)
	e5:SetCondition(function(e,tp) return Duel.IsTurnPlayer(tp) and c33900648.PlayerControlsAttributeOrIsAffectedByClearWall(tp,ATTRIBUTE_EARTH) and c:IsHasEffect(c33900648) and not c:HasFlagEffect(c33900648) and (not copying or c:IsFieldID(fc33900648)) end)
	e5:SetOperation(c33900648.desop)
	if copying then
		e5:SetReset(RESET_PHASE|PHASE_END)
	end
	Duel.RegisterEffect(e5,0)
	local e5b=e5:Clone()
	Duel.RegisterEffect(e5b,1)
	--● WATER: Discard 1 card
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringc33900648(c33900648,2))
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e6:SetCode(EVENT_PHASE+PHASE_END)
	e6:SetRange(LOCATION_FZONE)
	e6:SetCountLimit(1)
	e6:SetCondition(function(e,tp) return Duel.IsTurnPlayer(tp) and c33900648.PlayerControlsAttributeOrIsAffectedByClearWall(tp,ATTRIBUTE_WATER) and c:IsHasEffect(c33900648) and not c:HasFlagEffect(c33900648+1) and (not copying or c:IsFieldID(fc33900648)) end)
	e6:SetOperation(c33900648.discardop)
	if copying then
		e6:SetReset(RESET_PHASE|PHASE_END)
	end
	Duel.RegisterEffect(e6,0)
	local e6b=e6:Clone()
	Duel.RegisterEffect(e6b,1)
	--● FIRE: Take 1000 damage
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringc33900648(c33900648,3))
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e7:SetCode(EVENT_PHASE+PHASE_END)
	e7:SetRange(LOCATION_FZONE)
	e7:SetCondition(function(e,tp) return Duel.IsTurnPlayer(tp) and c33900648.PlayerControlsAttributeOrIsAffectedByClearWall(tp,ATTRIBUTE_FIRE) and c:IsHasEffect(c33900648) and not c:HasFlagEffect(c33900648+2) and (not copying or c:IsFieldID(fc33900648)) end)
	e7:SetOperation(c33900648.damop)
	if copying then
		e7:SetReset(RESET_PHASE|PHASE_END)
	end
	Duel.RegisterEffect(e7,0)
	local e7b=e7:Clone()
	Duel.RegisterEffect(e7b,1)
	--● WIND: You must pay 500 Life Points to activate a Spell Card
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_FIELD)
	e8:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e8:SetCode(EFFECT_ACTIVATE_COST)
	e8:SetRange(LOCATION_FZONE)
	e8:SetTargetRange(1,0)
	e8:SetCondition(function(e) return c33900648.PlayerIsAffectedByClearWorld(e:GetHandlerPlayer(),ATTRIBUTE_WIND) end)
	e8:SetTarget(function(e,te,tp) return te:IsSpellEffect() and te:IsHasType(EFFECT_TYPE_ACTIVATE) end)
	e8:SetCost(function(e,te_or_c,tp) return Duel.CheckLPCost(tp,500) end)
	e8:SetOperation(function(e,tp) Duel.PayLPCost(tp,500) end)
	c:RegisterEffect(e8)
	local e9=e8:Clone()
	e9:SetTargetRange(0,1)
	e9:SetCondition(function(e) return c33900648.PlayerIsAffectedByClearWorld(1-e:GetHandlerPlayer(),ATTRIBUTE_WIND) end)
	c:RegisterEffect(e9)
	--Apply a dummy effect on itself to track whether the card's effects are currently active or not
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e10:SetCode(c33900648)
	e10:SetRange(LOCATION_FZONE)
	c:RegisterEffect(e10)
end
function c33900648.maintop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,c33900648)
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local b1=Duel.CheckLPCost(tp,500)
	local b2=true
	--Pay 500 LP or destroy this card
	local op=b1 and Duel.SelectEffect(tp,
		{b1,aux.Stringc33900648(c33900648,4)},
		{b2,aux.Stringc33900648(c33900648,5)}) or 2
	if op==1 then
		Duel.PayLPCost(tp,500)
	elseif op==2 then
		Duel.Destroy(e:GetHandler(),REASON_COST)
	end
end
function c33900648.PlayerControlsAttributeOrIsAffectedByClearWall(player,attribute)
	return Duel.IsPlayerAffectedByEffect(1-player,EFFECT_CLEAR_WALL)
		or Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsAttribute,attribute),player,LOCATION_MZONE,0,1,nil)
end
function c33900648.PlayerIsAffectedByClearWorld(player,attribute)
	return not Duel.IsPlayerAffectedByEffect(player,EFFECT_CLEAR_WORLD_IMMUNE)
		and c33900648.PlayerControlsAttributeOrIsAffectedByClearWall(player,attribute)
end
function c33900648.darkconyou(e)
	local affected_player=e:GetHandlerPlayer()
	return c33900648.PlayerIsAffectedByClearWorld(affected_player,ATTRIBUTE_DARK) and Duel.GetFieldGroupCount(affected_player,LOCATION_MZONE,0)>=2
end
function c33900648.darkconopp(e)
	local affected_player=1-e:GetHandlerPlayer()
	return c33900648.PlayerIsAffectedByClearWorld(affected_player,ATTRIBUTE_DARK) and Duel.GetFieldGroupCount(affected_player,LOCATION_MZONE,0)>=2
end
function c33900648.desop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(c33900648,RESETS_STANDARD_PHASE_END,0,1)
	if not c33900648.PlayerIsAffectedByClearWorld(tp,ATTRIBUTE_EARTH)
		or not Duel.IsExistingMatchingCard(Card.IsPosition,tp,LOCATION_MZONE,0,1,nil,POS_FACEUP_DEFENSE) then return end
	Duel.Hint(HINT_CARD,0,c33900648)
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,Card.IsPosition,tp,LOCATION_MZONE,0,1,1,nil,POS_FACEUP_DEFENSE)
	if #g==0 then return end
	Duel.HintSelection(g)
	Duel.Destroy(g,REASON_EFFECT)
end
function c33900648.discardop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(c33900648+1,RESETS_STANDARD_PHASE_END,0,1)
	if not c33900648.PlayerIsAffectedByClearWorld(tp,ATTRIBUTE_WATER)
		or Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0 then return end
	Duel.Hint(HINT_CARD,0,c33900648)
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.DiscardHand(tp,nil,1,1,REASON_EFFECT|REASON_DISCARD)
end
function c33900648.damop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(c33900648+2,RESETS_STANDARD_PHASE_END,0,1)
	if not c33900648.PlayerIsAffectedByClearWorld(tp,ATTRIBUTE_FIRE) then return end
	Duel.Hint(HINT_CARD,0,c33900648)
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Damage(tp,1000,REASON_EFFECT)
end