--二重の落とし穴
--Gemini Trap Hole
function c67045174.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c67045174.condition)
	e1:SetTarget(c67045174.target)
	e1:SetOperation(c67045174.activate)
	c:RegisterEffect(e1)
	aux.GlobalCheck(s,function()
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_BATTLED)
		ge1:SetOperation(c67045174.checkop)
		Duel.RegisterEffect(ge1,0)
	end)
end
c67045174.listed_card_types={TYPE_GEMINI}
function c67045174.gmreg(c)
	if c and c:IsGeminiStatus() and c:IsStatus(STATUS_BATTLE_DESTROYED) then
		c:RegisterFlagEffect(c67045174,RESET_PHASE+PHASE_DAMAGE,0,1)
	end
end
function c67045174.checkop(e,tp,eg,ep,ev,re,r,rp)
	c67045174.gmreg(Duel.GetAttacker())
	c67045174.gmreg(Duel.GetAttackTarget())
end
function c67045174.filter(c)
	return c:GetFlagEffect(c67045174)~=0
end
function c67045174.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c67045174.filter,1,nil)
end
function c67045174.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(nil,tp,0,LOCATION_MZONE,nil)
	if chk==0 then return #g>0 end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
end
function c67045174.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(nil,tp,0,LOCATION_MZONE,nil)
	if #g>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end