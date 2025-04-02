--レアメタル化・魔法反射装甲
--Rare Metalmorph (Goat)
function c504700017.initial_effect(c)
	aux.AddPersistentProcedure(c,0,c504700017.filter,CATEGORY_ATKCHANGE,EFFECT_FLAG_DAMAGE_CAL,nil,TIMING_DAMAGE_STEP,c504700017.condition,nil,nil,c504700017.operation)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(aux.PersistentTargetFilter)
	e1:SetValue(500)
	c:RegisterEffect(e1)
	--Destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetCondition(c504700017.descon2)
	e3:SetOperation(c504700017.desop2)
	c:RegisterEffect(e3)
end
function c504700017.descon2(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	return tc and eg:IsContains(tc)
end
function c504700017.desop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function c504700017.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c504700017.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_MACHINE)
end
function c504700017.tfilter1(c,tc)
	return c:IsSpell() and c:IsHasCardTarget(tc)
end
function c504700017.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c504700017.filter(tc) and tc:IsRelateToEffect(e) then
		local g=Duel.GetMatchingGroup(c504700017.tfilter1,tp,LOCATION_SZONE,LOCATION_SZONE,nil,tc)
		if #g>0 then
			local sg,fc504700017=g:GetMaxGroup(Card.GetFieldID)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetRange(LOCATION_SZONE)
			e1:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetCondition(c504700017.discon)
			e1:SetTarget(c504700017.distg)
			e1:SetLabel(fc504700017)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			c:RegisterEffect(e1,true)
		else
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetRange(LOCATION_SZONE)
			e1:SetCode(EVENT_CHAIN_SOLVING)
			e1:SetCondition(c504700017.discon2)
			e1:SetOperation(c504700017.disop2)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			c:RegisterEffect(e1,true)
		end
	end
end
function c504700017.discon(e)
	return e:GetHandler():GetCardTargetCount()>0
end
function c504700017.distg(e,c)
	local ec=e:GetHandler():GetFirstCardTarget()
	return c:GetFieldID()<=e:GetLabel() and ec and c:IsHasCardTarget(ec) and c:IsSpell()
end
function c504700017.discon2(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	if not tc or not re:IsActiveType(TYPE_SPELL) or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return g:IsContains(tc)
end
function c504700017.disop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
	e:Reset()
end