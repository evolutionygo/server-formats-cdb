--魅惑の女王 ＬＶ７
--Allure Queen LV7
function c50140163.initial_effect(c)
	--Register that it was Special Summoned by the effect of "Allure Queen LV5"
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e0:SetCode(EVENT_SPSUMMON_SUCCESS)
	e0:SetCondition(c50140163.regcon)
	e0:SetOperation(function(e) e:GetHandler():RegisterFlagEffect(c50140163,RESET_EVENT|RESETS_STANDARD&~RESET_TEMP_REMOVE,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringc50140163(c50140163,1)) end)
	c:RegisterEffect(e0)
	--Equip 1 monster your opponent controls to this card
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc50140163(c50140163,0))
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,0,EFFECT_COUNT_CODE_SINGLE)
	e1:SetCondition(c50140163.eqconignition)
	e1:SetTarget(c50140163.eqtg)
	e1:SetOperation(c50140163.eqop)
	c:RegisterEffect(e1)
	aux.AddEREquipLimit(c,c50140163.eqconignition,c50140163.eqval,c50140163.equipop,e1)
	--Quick Effect version for when the effect of "Golden Allure Queen" is applied
	local e2=e1:Clone()
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(TIMING_STANDBY_PHASE,TIMING_STANDBY_PHASE|TIMING_MAIN_END|TIMINGS_CHECK_MONSTER_E)
	e2:SetCondition(c50140163.eqconquick)
	c:RegisterEffect(e2)
	aux.AddEREquipLimit(c,c50140163.eqconquick,c50140163.eqval,c50140163.equipop,e2)
end
c50140163.listed_names={23756165} --"Allure Queen LV5"
c50140163.LVnum=7
c50140163.LVset=SET_ALLURE_QUEEN
function c50140163.regcon(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	local trig_loc,trig_code1,trig_code2=Duel.GetChainInfo(0,CHAININFO_TRIGGERING_LOCATION,CHAININFO_TRIGGERING_CODE,CHAININFO_TRIGGERING_CODE2)
	if not Duel.IsChainSolving() or (rc:IsRelateToEffect(re) and rc:IsFaceup() and rc:IsLocation(trig_loc)) then
		return rc:IsCode(23756165)
	end
	return trig_code1==23756165 or trig_code2==23756165
end
function c50140163.eqconignition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:HasFlagEffect(c50140163) and not c:GetEquipGroup():IsExists(Card.HasFlagEffect,1,nil,c50140163) and not (c:IsOriginalSetCard(SET_ALLURE_QUEEN) and Duel.IsPlayerAffectedByEffect(tp,EFFECT_GOLDEN_ALLURE_QUEEN))
end
function c50140163.eqconquick(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:HasFlagEffect(c50140163) and not c:GetEquipGroup():IsExists(Card.HasFlagEffect,1,nil,c50140163) and c:IsOriginalSetCard(SET_ALLURE_QUEEN) and Duel.IsPlayerAffectedByEffect(tp,EFFECT_GOLDEN_ALLURE_QUEEN)
end
function c50140163.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsAbleToChangeControler() end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(Card.IsAbleToChangeControler,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,Card.IsAbleToChangeControler,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,tp,0)
end
function c50140163.eqop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	local c=e:GetHandler()
	if not (c:IsRelateToEffect(e) and c:IsFaceup() and Duel.GetLocationCount(tp,LOCATION_SZONE)>0) then
		Duel.SendtoGrave(c,REASON_RULE,PLAYER_NONE,PLAYER_NONE)
	else
		c50140163.equipop(c,e,tp,tc)
	end
end
function c50140163.equipop(c,e,tp,tc)
	if not c:EquipByEffectAndLimitRegister(e,tp,tc,c50140163) then return end
	--If this card would be destroyed by battle, the equipped monster is destroyed instead
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_EQUIP)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_OWNER_RELATE)
	e1:SetCode(EFFECT_DESTROY_SUBSTITUTE)
	e1:SetValue(function(e,re,r,rp) return r&REASON_BATTLE>0 end)
	e1:SetReset(RESET_EVENT|RESETS_STANDARD)
	tc:RegisterEffect(e1)
end
function c50140163.eqval(ec,c,tp)
	return ec:IsControler(1-tp)
end