--ゴルゴニック・ガーディアン (Anime)
--Gorgonic Guardian (Anime)
--Scripted by the Razgriz
function c511027117.initial_effect(c)
	c:EnableReviveLimit()
	--Xyz Summon procedure
	aux.AddXyzProcedure(c,nil,3,2)
	--Destroy monsters with 0 ATK
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c511027117.desop)
	c:RegisterEffect(e1)
	--Negate the effects of 1 monster on the field and change its ATK to 0
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DISABLE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(aux.dxmcostgen(1,1,nil))
	e2:SetTarget(c511027117.diszatg)
	e2:SetOperation(c511027117.diszaop)
	c:RegisterEffect(e2,false,REGISTER_FLAG_DETACH_XMAT)
end
function c511027117.desfilter(c,e)
	return c:GetAttack()==0 and c:IsPosition(POS_FACEUP) and c:IsDestructable(e) and not c:IsImmuneToEffect(e)
end
function c511027117.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511027117.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,e)
	if #g>0 then
		Duel.Hint(HINT_CARD,1-tp,c511027117)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
function c511027117.diszafilter(c)
	return c:IsFaceup() and c:HasNonZeroAttack() and c:IsNegatableMonster()
end
function c511027117.diszatg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511027117.diszafilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,nil,1,0,LOCATION_MZONE)
end
function c511027117.diszaop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,c511027117.diszafilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.HintSelection(g)
	local tc=g:GetFirst()
	if tc then
		tc:NegateEffects(c)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetRange(LOCATION_MZONE)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT|RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end