--ダメージ・ダイエット
--Damage Diet
function c95448692.initial_effect(c)
	--Halve all damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c95448692.target)
	e1:SetOperation(c95448692.activate)
	c:RegisterEffect(e1)
	--Halve effect damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c95448692.target2)
	e2:SetOperation(c95448692.activate2)
	c:RegisterEffect(e2)
end
function c95448692.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetFlagEffect(tp,c95448692)==0 end
end
function c95448692.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,c95448692)~=0 then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(c95448692.val1)
	e1:SetReset(RESET_PHASE|PHASE_END,1)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,c95448692,RESET_PHASE|PHASE_END,0,1)
end
function c95448692.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetFlagEffect(tp,c95448692)==0 and Duel.GetFlagEffect(tp,c95448692+1)==0 end
end
function c95448692.activate2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,c95448692+1)~=0 then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(c95448692.val2)
	e1:SetReset(RESET_PHASE|PHASE_END)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,c95448692+1,RESET_PHASE|PHASE_END,0,1)
end
function c95448692.val1(e,re,dam,r,rp,rc)
	if r&(REASON_BATTLE+REASON_EFFECT)~=0 then
		return dam/2
	else return dam end
end
function c95448692.val2(e,re,dam,r,rp,rc)
	if (r&REASON_EFFECT)~=0 then
		return dam/2
	else return dam end
end