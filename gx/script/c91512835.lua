--インセクト女王
--Insect Queen
function c91512835.initial_effect(c)
	--Must Tribute 1 monster to declare an attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ATTACK_COST)
	e1:SetCost(c91512835.atcost)
	e1:SetOperation(c91512835.atop)
	c:RegisterEffect(e1)
	--This card gains 200 ATK for each Insect monster on the field
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c91512835.value)
	c:RegisterEffect(e2)
	--Register flag if this card destroys a monster by battle
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetOperation(c91512835.regop)
	c:RegisterEffect(e3)
	--Special Summon 1 "Insect Monster Token" during End Phase
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringc91512835(c91512835,0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetCountLimit(1)
	e4:SetCondition(function(e) return e:GetHandler():HasFlagEffect(c91512835) end)
	e4:SetTarget(c91512835.sptg)
	e4:SetOperation(c91512835.spop)
	c:RegisterEffect(e4)
end
c91512835.listed_names={TOKEN_INSECT_MONSTER}
function c91512835.atfilter(c,tp)
	return c:IsLocation(LOCATION_MZONE) or (Duel.IsPlayerAffectedByEffect(tp,300307012) and c:IsLocation(LOCATION_HAND) and c:IsRace(RACE_INSECT)) 
end
function c91512835.atcost(e,c,tp)
	return Duel.CheckReleaseGroupCost(tp,c91512835.atfilter,1,true,nil,e:GetHandler(),tp)
end
function c91512835.atop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsAttackCostPac91512835()~=2 and e:GetHandler():IsLocation(LOCATION_MZONE) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		local tc=Duel.GetReleaseGroup(tp,true,false,REASON_COST):Filter(c91512835.atfilter,c,tp):SelectUnselect(Group.CreateGroup(),tp,Duel.IsAttackCostPac91512835()==0,Duel.IsAttackCostPac91512835()==0)
		if tc then
			Duel.Release(tc,REASON_COST)
			Duel.AttackCostPac91512835()
		else
			Duel.AttackCostPac91512835(2)
		end
	end
end
function c91512835.value(e,c)
	return Duel.GetMatchingGroupCount(aux.FaceupFilter(Card.IsRace,RACE_INSECT),0,LOCATION_MZONE,LOCATION_MZONE,nil)*200
end
function c91512835.regop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(c91512835,RESETS_STANDARD_PHASE_END,0,1)
end
function c91512835.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0)
end
function c91512835.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,TOKEN_INSECT_MONSTER,0,TYPES_TOKEN,100,100,1,RACE_INSECT,ATTRIBUTE_EARTH) then
		local token=Duel.CreateToken(tp,TOKEN_INSECT_MONSTER)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP_ATTACK)
	end
end