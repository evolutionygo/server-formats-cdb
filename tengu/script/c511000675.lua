--ダーク・リベリオン・エクシーズ・ドラゴン (Anime)
--Dark Rebellion Xyz Dragon (Anime)
function c511000675.initial_effect(c)
	c:EnableReviveLimit()
	--Xyz Summon procedure
	aux.AddXyzProcedure(c,nil,4,2)
	--Halve ATK and increase ATK
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511000675(c511000675,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(aux.dxmcostgen(1,1,nil))
	e1:SetTarget(c511000675.target)
	e1:SetOperation(c511000675.operation)
	c:RegisterEffect(e1,false,REGISTER_FLAG_DETACH_XMAT)
end
function c511000675.atkfilter(c)
	return c:IsLevelAbove(5) and c:HasNonZeroAttack()
end
function c511000675.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c511000675.atkfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000675.atkfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511000675.atkfilter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c511000675.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) then
		local c=e:GetHandler()
		local val=math.ceil(tc:GetAttack()/2)
		--Halve ATK
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(val)
		tc:RegisterEffect(e1)
		if c:IsRelateToEffect(e) and c:IsFaceup() then
			--Increase ATK
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			e2:SetValue(val)
			c:RegisterEffect(e2)
		end
	end
end