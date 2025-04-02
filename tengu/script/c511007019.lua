--連鎖召喚 (Manga)
--Chain Summon (Manga)
--coded by Lyris
--fixed by MLD
function c511007019.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511007019.condition)
	e1:SetTarget(c511007019.target)
	e1:SetOperation(c511007019.activate)
	c:RegisterEffect(e1)
	e1:SetLabelObject(g)
	aux.GlobalCheck(s,function()
		s[0]=false
		s[1]=false
		s[2]=false
		s[3]=false
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetOperation(c511007019.checkop)
		ge1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511007019.clear)
		Duel.RegisterEffect(ge2,0)
		local ge3=Effect.CreateEffect(c)
		ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge3:SetCode(EVENT_CHAIN_SOLVED)
		ge3:SetOperation(c511007019.resetop)
		ge3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		Duel.RegisterEffect(ge3,0)
		local ge4=ge1:Clone()
		ge4:SetCode(EVENT_SUMMON_SUCCESS)
		ge4:SetOperation(c511007019.resetop2)
		Duel.RegisterEffect(ge4,0)
		local ge5=ge4:Clone()
		ge5:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
		Duel.RegisterEffect(ge5,0)
		local ge6=ge4:Clone()
		ge6:SetCode(EVENT_DAMAGE_STEP_END)
		Duel.RegisterEffect(ge6,0)
		local ge7=ge4:Clone()
		ge7:SetCode(EVENT_CHANGE_POS)
		ge7:SetOperation(c511007019.resetop3)
		Duel.RegisterEffect(ge7,0)
	end)
end
function c511007019.cfilter(c,tp)
	return c:IsSummonType(SUMMON_TYPE_XYZ) and c:IsSummonPlayer(tp)
end
function c511007019.checkop(e,tp,eg,ep,ev,re,r,rp)
	if eg:IsExists(c511007019.cfilter,1,nil,tp) then
		if s[tp] then
			s[tp+2]=true
		else
			s[tp]=true
		end
		if Duel.GetCurrentChain()>0 then
			Duel.RegisterFlagEffect(tp,c511007019,RESET_CHAIN,0,1)
		end
	else
		s[tp]=false
	end
	if eg:IsExists(c511007019.cfilter,1,nil,1-tp) then
		if s[1-tp] then
			s[1-tp+2]=true
		else
			s[1-tp]=true
		end
		if Duel.GetCurrentChain()>0 then
			Duel.RegisterFlagEffect(1-tp,c511007019,RESET_CHAIN,0,1)
		end
	else
		s[1-tp]=false
	end
end
function c511007019.resetop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(rp,c511007019)==0 then s[rp]=false end
	s[1-rp]=false
end
function c511007019.resetop2(e,tp,eg,ep,ev,re,r,rp)
	s[0]=false
	s[1]=false
end
function c511007019.resetop3(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetCurrentChain()==0 then
		s[0]=false
		s[1]=false
	end
end
function c511007019.clear(e,tp,eg,ep,ev,re,r,rp)
	s[0]=false
	s[1]=false
	s[2]=false
	s[3]=false
end
function c511007019.condition(e,tp,eg,ep,ev,re,r,rp)
	return s[tp+2]
end
function c511007019.spfilter(c,e,tp,rk)
	return c:IsType(TYPE_XYZ) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) 
		and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
		and not Duel.IsExistingMatchingCard(c511007019.filter,tp,LOCATION_MZONE,0,1,nil,c:GetRank())
end
function c511007019.filter(c,rk)
	return c:IsFaceup() and c:GetRank()<=rk
end
function c511007019.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511007019.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511007019.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c511007019.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if #sg>0 then
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end